window.BENCHMARK_DATA = {
  "lastUpdate": 1745738842214,
  "repoUrl": "https://github.com/oameye/KeldyshContraction.jl",
  "entries": {
    "Benchmark Results": [
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "641267ca1ce1cfdf5323db30d2649f545d515580",
          "message": "feat: add benchmark tracking (#15)",
          "timestamp": "2025-04-23T08:18:27+02:00",
          "tree_id": "67580bca6aad1d61c1cc8c00831686fed5263d5b",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/641267ca1ce1cfdf5323db30d2649f545d515580"
        },
        "date": 1745389242471,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 426988.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96512\nallocs=2057\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7323716,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3821520\nallocs=70823\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "f33688d8680d11721bc9e9e45d7925f641019de1",
          "message": "Update Benchmarks.yaml (#19)",
          "timestamp": "2025-04-23T09:42:54+02:00",
          "tree_id": "d8d807041bca152295764b1f175c778ea2483e74",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/f33688d8680d11721bc9e9e45d7925f641019de1"
        },
        "date": 1745394254914,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 449561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96424\nallocs=2059\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7637369,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3822736\nallocs=70833\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "7d1692c55d7aa466a09aced72ecedb457c3d7486",
          "message": "feat: add `*(b::QAdd, a::QField)` (#20)",
          "timestamp": "2025-04-23T10:46:13+02:00",
          "tree_id": "1d552b65612cbf18d2e843e61849b736fbb20209",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/7d1692c55d7aa466a09aced72ecedb457c3d7486"
        },
        "date": 1745398049866,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 461402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96592\nallocs=2059\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7513236.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3822784\nallocs=70833\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "9fdf6958c558d5d4cd0ed1cf846bdcc3f7ad2a10",
          "message": "fix: fix convention and add support for imaginary numbers (#21)",
          "timestamp": "2025-04-23T15:41:20+02:00",
          "tree_id": "23525fa62290a8cc21aec100203a0b515100d6c3",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/9fdf6958c558d5d4cd0ed1cf846bdcc3f7ad2a10"
        },
        "date": 1745415773564,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 489982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 8162294,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3943856\nallocs=74239\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "1b1c9cd37d123c5d5547e51ee0c1ae3b0379610b",
          "message": "docs: add docs convention (#22)",
          "timestamp": "2025-04-23T16:36:51+02:00",
          "tree_id": "f65c48aecaab9f41979e2209c1ca1efe1ad5954d",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/1b1c9cd37d123c5d5547e51ee0c1ae3b0379610b"
        },
        "date": 1745419092359,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 506329,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116416\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 8216695.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3943880\nallocs=74239\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "04f5bd7501d45c0f83a5ad04a5e4f33fc44f7b36",
          "message": "docs: add docs convention (#23)",
          "timestamp": "2025-04-23T18:42:40+02:00",
          "tree_id": "a1867b51d2873a61f4002cad7d34598c25598112",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/04f5bd7501d45c0f83a5ad04a5e4f33fc44f7b36"
        },
        "date": 1745426640195,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 548809,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116400\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6115293.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2363592\nallocs=49772\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "39ddd9369c4626a59cdc71b75d9a11394f91da8d",
          "message": "implement adjoint (#24)",
          "timestamp": "2025-04-24T11:56:26+02:00",
          "tree_id": "454df5dc16aaf86b23f2dae225ab5952017d70c8",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/39ddd9369c4626a59cdc71b75d9a11394f91da8d"
        },
        "date": 1745488667978,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 518146,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6261682,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2428800\nallocs=51507\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "3a3c9983ef7a1d138f91d483240a5b0754b0037e",
          "message": "Update pull_request_template.md (#26)",
          "timestamp": "2025-04-24T12:10:13+02:00",
          "tree_id": "34c10c385398229e6c72c9ff108e4f222beec7fc",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/3a3c9983ef7a1d138f91d483240a5b0754b0037e"
        },
        "date": 1745489519692,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 517994,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116416\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6283296,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2428904\nallocs=51509\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "ec4d22a6f40f0a22626aec72c1becf02289b4a83",
          "message": "feat: don't run Tests CI when only docs changes (#27)",
          "timestamp": "2025-04-24T12:37:07+02:00",
          "tree_id": "cd078b5e097983114840befead5005a0f5df1e8f",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/ec4d22a6f40f0a22626aec72c1becf02289b4a83"
        },
        "date": 1745491105185,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 504747,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6145907,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2428736\nallocs=51507\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "2a28ba8ae4a5615b23165e4817fb62a852f47f4d",
          "message": "feat: add docstring to Module (#28)",
          "timestamp": "2025-04-24T13:49:36+02:00",
          "tree_id": "f6149fd467478722dd87d0e105e9666423ff125f",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/2a28ba8ae4a5615b23165e4817fb62a852f47f4d"
        },
        "date": 1745495454175,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 515254,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116400\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6191538,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2428744\nallocs=51507\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "3fa2ef7e3f41097de1a84c2a2172077f5c90da94",
          "message": "Update Tests.yml (#34)",
          "timestamp": "2025-04-25T09:09:52+02:00",
          "tree_id": "0ee9d0f25db979880577ec54d020f856b25f0da5",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/3fa2ef7e3f41097de1a84c2a2172077f5c90da94"
        },
        "date": 1745565068136,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 536978,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116392\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 6191396,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2428704\nallocs=51506\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "3ed3dd3d30afd0512f2368e8b387066a0efaefc3",
          "message": "refactor: change Position Enum for AbstractPosition structs (#35)",
          "timestamp": "2025-04-26T12:09:02+02:00",
          "tree_id": "ef574cd0dab73b57763421baaa1199f9a482a955",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/3ed3dd3d30afd0512f2368e8b387066a0efaefc3"
        },
        "date": 1745662227163,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 602627,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126080\nallocs=2858\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7064449,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494384\nallocs=53475\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "dcc3314a89db5bcaad63e486755655ef9adc0c6e",
          "message": "feat: change Bulk for InteractionLagrangian (#43)",
          "timestamp": "2025-04-26T21:44:14+02:00",
          "tree_id": "cc4c3e62502e319cad7935f2e1241a410da2eb4e",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/dcc3314a89db5bcaad63e486755655ef9adc0c6e"
        },
        "date": 1745696729015,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 591728,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126448\nallocs=2874\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7301826,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494120\nallocs=53473\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "8be83956cdd74a2a9398868f178d6f4c04c4f3f2",
          "message": "refactor: update Bulk default index (#44)",
          "timestamp": "2025-04-26T21:51:55+02:00",
          "tree_id": "336c62fd82ae097008909c85dc3cc16af9555e78",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/8be83956cdd74a2a9398868f178d6f4c04c4f3f2"
        },
        "date": 1745697187549,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 564248,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126232\nallocs=2864\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7007218,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494248\nallocs=53474\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "7ff493c87d05a8ba3a0ff87291c66fb056681a2a",
          "message": "feat: implement second order perturbation theory (#45)",
          "timestamp": "2025-04-26T23:00:49+02:00",
          "tree_id": "03423fbdafb5e95491d3e2a2bdc1bd63e48e7557",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/7ff493c87d05a8ba3a0ff87291c66fb056681a2a"
        },
        "date": 1745701460336,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 604252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=125736\nallocs=2841\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7247768.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494296\nallocs=53473\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function second_order",
            "value": 2726686452,
            "unit": "ns",
            "extra": "gctime=350847474\nmemory=4251519056\nallocs=69337986\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "b6c80688cf40df65fb146e286b0eb30d0ae251d5",
          "message": "docs: update docstring to remove module prefix for clarity (#47)",
          "timestamp": "2025-04-27T08:18:53+02:00",
          "tree_id": "32943b20437a6077bffcf6e61abe7321acb20c88",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/b6c80688cf40df65fb146e286b0eb30d0ae251d5"
        },
        "date": 1745734943586,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 619226.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126296\nallocs=2867\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7169474,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2493920\nallocs=53464\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function second_order",
            "value": 2708640708,
            "unit": "ns",
            "extra": "gctime=344895662\nmemory=4251509480\nallocs=69337973\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "orjan.ameye@hotmail.com",
            "name": "Orjan Ameye",
            "username": "oameye"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "8e460a11dc044d3bc06f7f77bd0fc6bbbdd10a02",
          "message": "docs: add more private docstrings (#49)",
          "timestamp": "2025-04-27T09:23:46+02:00",
          "tree_id": "b52641e508d403ba5f3f1caf3d501eb888753ae1",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/8e460a11dc044d3bc06f7f77bd0fc6bbbdd10a02"
        },
        "date": 1745738841271,
        "tool": "julia",
        "benches": [
          {
            "name": "two body loss/self energy",
            "value": 615436.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=125936\nallocs=2849\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function",
            "value": 7257640,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494192\nallocs=53472\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "two body loss/Green's function second_order",
            "value": 2743641921,
            "unit": "ns",
            "extra": "gctime=366672781\nmemory=4251511496\nallocs=69338190\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      }
    ]
  }
}