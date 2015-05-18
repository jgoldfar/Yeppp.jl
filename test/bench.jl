include(joinpath(dirname(@__FILE__), "..", "Yeppp.jl"))

function test_log_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x = rand(ntest)
    y = zeros(ntest)
    t1 = @elapsed begin
        for i in 1:nsamples
            Yeppp.log!(y, x)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = log(x)
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            for j in 1:ntest
                y[j] = log(x[j])
            end
        end
    end
    gc()

    @printf "-------\nWith log:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_log_devec(nsamples = 2)

function test_sum_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x = rand(ntest)
    y = 0.0
    t1 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = Yeppp.sum(x)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = sum(x)
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            for j in 1:ntest
                y += x[j]
            end
        end
    end
    gc()

    @printf "-------\nWith sum:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_sum_devec(nsamples = 2)


function test_sumabs2_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x = rand(ntest)
    y = 0.0
    t1 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = Yeppp.sumabs2(x)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = sumabs2(x)
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            for j in 1:ntest
                y += abs2(x[j])
            end
        end
    end
    gc()

    @printf "-------\nWith sumabs2:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_sumabs2_devec(nsamples = 2)


function test_subtract_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x1 = rand(ntest)
    const x2 = rand(ntest)
    y = zeros(ntest)
    t1 = @elapsed begin
        for i in 1:nsamples
            Yeppp.subtract!(y, x1, x2)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = x2 - x1
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            for j in 1:ntest
                y[j] = x2[j] - x1[j]
            end
        end
    end
    gc()

    @printf "-------\nWith subtract!:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_subtract_devec(nsamples = 2)

function test_add_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x1 = rand(ntest)
    const x2 = rand(ntest)
    y = zeros(ntest)
    t1 = @elapsed begin
        for i in 1:nsamples
            Yeppp.add!(y, x1, x2)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = x2 + x1
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            for j in 1:ntest
                y[j] = x2[j] + x1[j]
            end
        end
    end
    gc()

    @printf "-------\nWith add!:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_add_devec(nsamples = 2)


function test_dot_devec(;ntest::Int = 10^7, nsamples::Int = 1)
    const x1 = rand(ntest)
    const x2 = rand(ntest)
    t1 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = Yeppp.dot(x1, x2)
        end
    end
    gc()
    t2 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            y = dot(x2, x1)
        end
    end
    gc()
    t3 = @elapsed begin
        for i in 1:nsamples
            y = 0.0
            for j in 1:ntest
                y += x2[j] * x1[j]
            end
        end
    end
    gc()

    @printf "-------\nWith dot:\n"
    @printf "elapsed in Yeppp: %e\n" (t1 / nsamples)
    @printf "elapsed in Julia, vectorized: %e. Yeppp speedup: %e\n" (t2 / nsamples) (t2 / t1)
    @printf "elapsed in Julia, devectorized: %e. Yeppp speedup: %e\n-------\n" (t3 / nsamples) (t3 / t1)
end
test_dot_devec(nsamples = 2)
