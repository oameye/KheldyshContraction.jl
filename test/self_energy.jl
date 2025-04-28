using KeldyshContraction, Test

@testset "self_energy_type" begin
    using KeldyshContraction: self_energy_type, OrderedCollections, In, Out, Keldysh
    dict = OrderedCollections.LittleDict(In() => Keldysh, Out() => Keldysh)
    @test_throws "should be zero" self_energy_type(dict)
end
