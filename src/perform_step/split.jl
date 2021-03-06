@muladd function perform_step!(integrator,cache::SplitEMConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,W,p = integrator
  u = dt*(integrator.f[1](uprev,p,t) +
           integrator.f[2](uprev,p,t)) +
           integrator.g(uprev,p,t).*W.dW + uprev
  integrator.u = u
end

@muladd function perform_step!(integrator,cache::SplitEMCache,f=integrator.f)
  @unpack rtmp1,rtmp2,rtmp3 = cache
  @unpack t,dt,uprev,u,W,p = integrator

  integrator.g(rtmp2,uprev,p,t)
  if is_diagonal_noise(integrator.sol.prob)
    scale!(rtmp2,W.dW) # rtmp2 === rtmp3
  else
    A_mul_B!(rtmp3,rtmp2,W.dW)
  end

  integrator.f[1](t,uprev,rtmp1)
  #@. u = @muladd uprev + dt*rtmp1 + rtmp3
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] = @muladd uprev[i] + dt*rtmp1[i] + rtmp3[i]
  end
  integrator.f[2](t,uprev,rtmp1)
  #@. u = @muladd u + dt*rtmp1
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] = @muladd u[i] + dt*rtmp1[i]
  end
end
