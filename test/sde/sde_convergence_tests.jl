@everywhere using StochasticDiffEq, DiffEqProblemLibrary, DiffEqDevTools, Base.Test
srand(100)
dts = 1./2.^(10:-1:2) #14->7 good plot

prob = prob_sde_wave
sim  = test_convergence(dts,prob,ImplicitEM(),numMonte=Int(1e1))
@test abs(sim.𝒪est[:l2]-.5) < 0.2
sim  = test_convergence(dts,prob,ImplicitRKMil(),numMonte=Int(1e2))
@test abs(sim.𝒪est[:l2]-1) < 0.2
sim  = test_convergence(dts,prob,EM(),numMonte=Int(1e2))
@test abs(sim.𝒪est[:l2]-.5) < 0.2
sim2 = test_convergence(dts,prob,RKMil(),numMonte=Int(2e2))
@test abs(sim2.𝒪est[:l∞]-1) < 0.2
sim3 = test_convergence(dts,prob,SRI(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-1.5) < 0.3
sim4 = test_convergence(dts,prob,SRIW1(),numMonte=Int(1e1))
@test abs(sim4.𝒪est[:final]-1.5) < 0.3
sim5 = test_convergence(dts,prob,SRIW2(),numMonte=Int(1e1))
@test abs(sim5.𝒪est[:final]-1.5) < 0.3
sim6 = test_convergence(dts,prob,SOSRI(),numMonte=Int(1e1))
@test abs(sim6.𝒪est[:final]-1.5) < 0.3
sim7 = test_convergence(dts,prob,SOSRI2(),numMonte=Int(1e1))
@test abs(sim7.𝒪est[:final]-1.5) < 0.3

prob = prob_sde_cubic
sim  = test_convergence(dts,prob,EM(),numMonte=Int(1e1))
@test abs(sim.𝒪est[:l2]-.5) < 0.2
sim  = test_convergence(dts,prob,ImplicitEM(),numMonte=Int(1e2))
@test abs(sim.𝒪est[:l2]-.5) < 0.2
sim  = test_convergence(dts,prob,ImplicitRKMil(),numMonte=Int(1e2))
@test abs(sim.𝒪est[:l2]-1) < 0.2
sim2 = test_convergence(dts,prob,RKMil(),numMonte=Int(1e2))
@test abs(sim2.𝒪est[:l∞]-1) < 0.22
sim3 = test_convergence(dts,prob,SRI(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-1.5) < 0.3
sim4 = test_convergence(dts,prob,SRIW1(),numMonte=Int(1e1))
@test abs(sim4.𝒪est[:final]-1.5) < 0.3
sim5 = test_convergence(dts,prob,SRIW2(),numMonte=Int(1e1))
@test abs(sim5.𝒪est[:final]-1.5) < 0.3
sim6 = test_convergence(dts,prob,SOSRI(),numMonte=Int(1e1))
@test abs(sim6.𝒪est[:final]-1.5) < 0.3
sim7 = test_convergence(dts,prob,SOSRI2(),numMonte=Int(1e1))
@test abs(sim7.𝒪est[:final]-1.5) < 0.3

prob = prob_sde_additive
sim  = test_convergence(dts,prob,EM(),numMonte=Int(1e1))
@test abs(sim.𝒪est[:l2]-1) < 0.2
sim  = test_convergence(dts,prob,ImplicitEM(),numMonte=Int(1e1))
@test abs(sim.𝒪est[:l2]-1.5) < 0.2
sim  = test_convergence(dts,prob,ImplicitRKMil(),numMonte=Int(1e1))
@test abs(sim.𝒪est[:l2]-1.5) < 0.2
sim2 = test_convergence(dts,prob,RKMil(),numMonte=Int(1e1))
@test abs(sim2.𝒪est[:l∞]-1) < 0.2
sim3 = test_convergence(dts,prob,SRI(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-2) < 0.3
sim3 = test_convergence(dts,prob,SRIW2(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-2) < 0.3
sim3 = test_convergence(dts,prob,SOSRI(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-2) < 0.3
sim3 = test_convergence(dts,prob,SOSRI2(),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-2) < 0.3

sim4 = test_convergence(dts,prob,SRA(),numMonte=Int(1e1))
@test abs(sim4.𝒪est[:final]-2) < 0.3
sim5 = test_convergence(dts,prob,SRA1(),numMonte=Int(1e1))
@test abs(sim5.𝒪est[:final]-2) < 0.3
sim6 = test_convergence(dts,prob,SRA2(),numMonte=Int(1e1))
@test abs(sim6.𝒪est[:final]-2) < 0.3
sim7 = test_convergence(dts,prob,SRA3(),numMonte=Int(1e1))
@test abs(sim7.𝒪est[:final]-2.5) < 0.3
sim8 = test_convergence(dts,prob,SOSRA(),numMonte=Int(1e1))
@test abs(sim8.𝒪est[:final]-2) < 0.3
sim9 = test_convergence(dts,prob,SOSRA2(),numMonte=Int(1e1))
@test abs(sim9.𝒪est[:final]-2) < 0.3
dts = 1./2.^(10:-1:4) #14->7 good plot
sim10 = test_convergence(dts,prob,RackKenCarp(),numMonte=Int(1e1))
@test abs(sim10.𝒪est[:final]-2) < 0.3
sim11 = test_convergence(dts,prob,RackKenCarp(min_newton_iter=3),numMonte=Int(1e1))
@test abs(sim10.𝒪est[:final]-2) < 0.3

sim2 = test_convergence(dts,prob,SRA(tableau=StochasticDiffEq.constructSRA2()),numMonte=Int(1e1))
@test abs(sim2.𝒪est[:final]-2) < 0.3
sim3 = test_convergence(dts,prob,SRA(tableau=StochasticDiffEq.constructSRA3()),numMonte=Int(1e1))
@test abs(sim3.𝒪est[:final]-2.5) < 0.3
sim6 = test_convergence(dts,prob,SRIW1(),numMonte=Int(1e1))
@test abs(sim6.𝒪est[:final]-2) < 0.3
sim2 = test_convergence(dts,prob,SRA(tableau=StochasticDiffEq.constructExplicitRackKenCarp()),numMonte=Int(1e1))
@test abs(sim2.𝒪est[:final]-2) < 0.3
