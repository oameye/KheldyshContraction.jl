window.BENCHMARK_DATA = {
  "lastUpdate": 1748088077704,
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
            "name": "Two body loss/Self-energy",
            "value": 426988.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96512\nallocs=2057\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 449561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96424\nallocs=2059\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 461402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=96592\nallocs=2059\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 489982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 506329,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116416\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 548809,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116400\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 518146,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 517994,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116416\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 504747,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116376\nallocs=2460\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 515254,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116400\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 536978,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116392\nallocs=2459\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 602627,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126080\nallocs=2858\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 591728,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126448\nallocs=2874\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 564248,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126232\nallocs=2864\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":5,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
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
            "name": "Two body loss/Self-energy",
            "value": 604252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=125736\nallocs=2841\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7247768.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494296\nallocs=53473\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
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
            "name": "Two body loss/Self-energy",
            "value": 619226.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=126296\nallocs=2867\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7169474,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2493920\nallocs=53464\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
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
            "name": "Two body loss/Self-energy",
            "value": 615436.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=125936\nallocs=2849\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7257640,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494192\nallocs=53472\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 2743641921,
            "unit": "ns",
            "extra": "gctime=366672781\nmemory=4251511496\nallocs=69338190\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "8842ad9bbd68de512373721b59dc21a18014ca9f",
          "message": "refactor: compute self energy by using the keldysh matrix formula (#55)",
          "timestamp": "2025-04-28T20:42:54+02:00",
          "tree_id": "bf3cf0e21a399740ac56a63d374aaee7cd213c57",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/8842ad9bbd68de512373721b59dc21a18014ca9f"
        },
        "date": 1745866013300,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Self-energy",
            "value": 614408,
            "unit": "ns",
            "extra": "gctime=0\nmemory=124272\nallocs=2878\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7347591,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494272\nallocs=53468\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 2757542894,
            "unit": "ns",
            "extra": "gctime=353927445\nmemory=4251554184\nallocs=69339899\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "528a55ce0d136ccf41d5fd8f3f2cadfbc90307a2",
          "message": "feat: export `arguments` (#57)",
          "timestamp": "2025-04-28T21:36:14+02:00",
          "tree_id": "edcad703f04f897118a03e333dd14637fbfdeb5a",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/528a55ce0d136ccf41d5fd8f3f2cadfbc90307a2"
        },
        "date": 1745869187688,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Self-energy",
            "value": 562245,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123256\nallocs=2830\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7158193.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2494112\nallocs=53473\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 2835569122,
            "unit": "ns",
            "extra": "gctime=362894701\nmemory=4251598952\nallocs=69340820\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "09710bc6a3479946b1d83d6a1b053b3ff8895c0b",
          "message": "fix: self-interaction (#59)\n\n* fix: self-interaction\n\n* feat: add simplification rule for advanced to retarded\n\n* don't simplify for two boson loss bench\n\n* test: add more tests",
          "timestamp": "2025-04-29T14:43:01+02:00",
          "tree_id": "90ed4d68383dfeeb24f9301079e8eaad3af097f4",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/09710bc6a3479946b1d83d6a1b053b3ff8895c0b"
        },
        "date": 1745930808338,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Self-energy",
            "value": 532131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=114664\nallocs=2627\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 7669694,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2549232\nallocs=54569\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 2918611252.5,
            "unit": "ns",
            "extra": "gctime=406646428.5\nmemory=4262261736\nallocs=69552378\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "192930efe0ba3b47f450d51462a10d7a27ca79ca",
          "message": "refactor: faster wick_contraction (#42)",
          "timestamp": "2025-04-29T16:37:15+02:00",
          "tree_id": "8e8c64d72c270852d6a550c979abaac5c1da3738",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/192930efe0ba3b47f450d51462a10d7a27ca79ca"
        },
        "date": 1745937646578,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Self-energy",
            "value": 528072,
            "unit": "ns",
            "extra": "gctime=0\nmemory=114392\nallocs=2612\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 6846862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1302080\nallocs=32404\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 526728002,
            "unit": "ns",
            "extra": "gctime=11765948\nmemory=129312152\nallocs=3245941\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "d477a54a0cc57c86c487ee825b5ef71430122361",
          "message": "build: add DEV flag to version (#66)",
          "timestamp": "2025-04-30T08:05:15+02:00",
          "tree_id": "e0264a9ce22ead2c026927198e683e27ee137ab9",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/d477a54a0cc57c86c487ee825b5ef71430122361"
        },
        "date": 1745993320503,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Self-energy",
            "value": 500093,
            "unit": "ns",
            "extra": "gctime=0\nmemory=114584\nallocs=2622\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function",
            "value": 6663464.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1301936\nallocs=32403\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 532255296.5,
            "unit": "ns",
            "extra": "gctime=11566785.5\nmemory=129393728\nallocs=3248421\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "63916062324d14d9fef4b252a7ef6bac624c016e",
          "message": "feat: add additional filters for second order (#65)",
          "timestamp": "2025-04-30T12:12:36+02:00",
          "tree_id": "cf760786ae40cc81e852a0cdc76147eb17db85a5",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/63916062324d14d9fef4b252a7ef6bac624c016e"
        },
        "date": 1746008288282,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 7323736.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424104\nallocs=35092\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 511972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=114688\nallocs=2625\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 506468935,
            "unit": "ns",
            "extra": "gctime=11643109\nmemory=122905632\nallocs=3031281\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5697348,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1171624\nallocs=28682\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 337362390.5,
            "unit": "ns",
            "extra": "gctime=7575658.5\nmemory=85999168\nallocs=2111055\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "b8773f1b2b86a24bc7d9c038af93460c108d7fce",
          "message": "refactor: move filters to separate file (#70)",
          "timestamp": "2025-05-03T18:05:00+02:00",
          "tree_id": "35534813c4fd76ad494024d361c1935380081909",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/b8773f1b2b86a24bc7d9c038af93460c108d7fce"
        },
        "date": 1746288653664,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 7303795,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424136\nallocs=35092\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 524282.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=114536\nallocs=2619\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 513235775.5,
            "unit": "ns",
            "extra": "gctime=12733270.5\nmemory=122914584\nallocs=3031310\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5707794,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1171672\nallocs=28689\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 343781634,
            "unit": "ns",
            "extra": "gctime=8108227\nmemory=85996232\nallocs=2111498\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "c601c6f3d588d0f5f77e4e33b4de6dacc56df196",
          "message": "refactor: remove metadata (#75)",
          "timestamp": "2025-05-04T15:59:19+02:00",
          "tree_id": "061c7a8bf51f5469594a953bb6297bf9d52fe969",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/c601c6f3d588d0f5f77e4e33b4de6dacc56df196"
        },
        "date": 1746367512548,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 7184101,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1423632\nallocs=35088\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 506263.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=113984\nallocs=2587\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 498686051,
            "unit": "ns",
            "extra": "gctime=11781138\nmemory=122868032\nallocs=3029535\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5621463,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1171864\nallocs=28690\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 347786023.5,
            "unit": "ns",
            "extra": "gctime=8166121.5\nmemory=85935640\nallocs=2111083\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "60de2b2fc4f20474abab52dd7d83fb5db04622f1",
          "message": "refactor: make keldysh algebra type-stable (#76)",
          "timestamp": "2025-05-04T22:49:07+02:00",
          "tree_id": "3cca5435d487d0399eaf4584c493a80e211da4b0",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/60de2b2fc4f20474abab52dd7d83fb5db04622f1"
        },
        "date": 1746392096711,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 6425296,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1500888\nallocs=37136\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 493115,
            "unit": "ns",
            "extra": "gctime=0\nmemory=116712\nallocs=2628\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 411639778,
            "unit": "ns",
            "extra": "gctime=10762997\nmemory=129907064\nallocs=3264301\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5214782,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1227368\nallocs=30029\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 289015029,
            "unit": "ns",
            "extra": "gctime=7113601\nmemory=90328392\nallocs=2231916\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "5ce9abdc440f57b3db48cf1a884db524d11403e7",
          "message": "test: enable JET (#79)",
          "timestamp": "2025-05-19T10:44:00+02:00",
          "tree_id": "84875dddad18adacc334410f698aedd8c00e5901",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/5ce9abdc440f57b3db48cf1a884db524d11403e7"
        },
        "date": 1747644623745,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 6760338,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1534264\nallocs=37528\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 512205,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123528\nallocs=2731\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 420129724.5,
            "unit": "ns",
            "extra": "gctime=12344022.5\nmemory=130692072\nallocs=3267391\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5156758,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1255648\nallocs=30363\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 292868687,
            "unit": "ns",
            "extra": "gctime=7328988\nmemory=97529160\nallocs=2276383\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "e0077205452fa52b2d531ff5aec1d031699b4a50",
          "message": "refactor: make keldysh_algebra folder (#80)",
          "timestamp": "2025-05-19T10:54:04+02:00",
          "tree_id": "76d215bc0dd0d81c0da33ad1bc14ad9c30def6bc",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/e0077205452fa52b2d531ff5aec1d031699b4a50"
        },
        "date": 1747645163747,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 6467721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1526232\nallocs=37440\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 483432.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123200\nallocs=2714\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 414192496,
            "unit": "ns",
            "extra": "gctime=11869465\nmemory=130874576\nallocs=3271822\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5050008,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1252288\nallocs=30323\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 295353893,
            "unit": "ns",
            "extra": "gctime=7808473\nmemory=97293816\nallocs=2276726\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "bbc2c409db7b9eb5c32b16f1f41e2eb2dafde620",
          "message": "refactor: restrict QMul to only numbers (#82)",
          "timestamp": "2025-05-19T16:31:20+02:00",
          "tree_id": "6c61ab06f7ccf1b71b0b68ead38cede0f84027b6",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/bbc2c409db7b9eb5c32b16f1f41e2eb2dafde620"
        },
        "date": 1747665412496,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 6306202.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1512064\nallocs=36840\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 490838.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123120\nallocs=2711\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 395494593,
            "unit": "ns",
            "extra": "gctime=11131475\nmemory=127848072\nallocs=3163027\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5038449,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1239016\nallocs=29863\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 283792315.5,
            "unit": "ns",
            "extra": "gctime=7321410\nmemory=96192824\nallocs=2229987\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "28672c729604eec991225808cdae64ddba5cd631",
          "message": "refactor: move reguralise pre-allocating step (#84)",
          "timestamp": "2025-05-19T20:22:45+02:00",
          "tree_id": "7c4894f42d6501c1565692adb3eae8d374b72266",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/28672c729604eec991225808cdae64ddba5cd631"
        },
        "date": 1747679305410,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 5160542,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1164752\nallocs=28227\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 501270,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123040\nallocs=2706\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 163646351,
            "unit": "ns",
            "extra": "gctime=6800427.5\nmemory=55699992\nallocs=1410589\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 5221315,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1215960\nallocs=29320\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 313390112,
            "unit": "ns",
            "extra": "gctime=12858743\nmemory=96975088\nallocs=2260089\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "b5291f01edca8ef92d1592adee7903b234bf9125",
          "message": "refactor make contraction a Tuple (#85)",
          "timestamp": "2025-05-19T22:10:10+02:00",
          "tree_id": "9d871147e21a5aaf0ec207c959c32919b56efc82",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/b5291f01edca8ef92d1592adee7903b234bf9125"
        },
        "date": 1747685737487,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3924175,
            "unit": "ns",
            "extra": "gctime=0\nmemory=819504\nallocs=19497\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 493378.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123064\nallocs=2706\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 41460314,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16548816\nallocs=355600\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4098965.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=917200\nallocs=21941\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 190913783,
            "unit": "ns",
            "extra": "gctime=7390540.5\nmemory=65248480\nallocs=1451151\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "a590b58c3211299ca0f1288d125c9e680f0bfee7",
          "message": "refactor: wick contraction (#86)",
          "timestamp": "2025-05-20T07:53:15+02:00",
          "tree_id": "149cbb0b669a2a364ae8b5eaca029e33c2a41eeb",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/a590b58c3211299ca0f1288d125c9e680f0bfee7"
        },
        "date": 1747720716296,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3767964,
            "unit": "ns",
            "extra": "gctime=0\nmemory=785496\nallocs=18682\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 526994.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123336\nallocs=2721\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 35067236,
            "unit": "ns",
            "extra": "gctime=0\nmemory=13104320\nallocs=276091\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4003228,
            "unit": "ns",
            "extra": "gctime=0\nmemory=905024\nallocs=21514\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 189495801.5,
            "unit": "ns",
            "extra": "gctime=6857803\nmemory=63591128\nallocs=1412638\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "cf7098e1ff2288ad8eff59b69fb6649ee732490b",
          "message": "refactor: clean up QMul and QAdd equality checks; add interface file (#87)",
          "timestamp": "2025-05-20T10:34:01+02:00",
          "tree_id": "502b72ca7551ada230cc2a1962bf7bed7c0026b4",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/cf7098e1ff2288ad8eff59b69fb6649ee732490b"
        },
        "date": 1747730359540,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3747973,
            "unit": "ns",
            "extra": "gctime=0\nmemory=786336\nallocs=18727\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 493798.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123416\nallocs=2724\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 33938360,
            "unit": "ns",
            "extra": "gctime=0\nmemory=13004736\nallocs=275624\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 3821465,
            "unit": "ns",
            "extra": "gctime=0\nmemory=896688\nallocs=21413\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 179771976,
            "unit": "ns",
            "extra": "gctime=6000275\nmemory=63412280\nallocs=1411332\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "93b273c2a88afb69eef596e25da33a4d5b260268",
          "message": "feat: is_connected diagram (#88)",
          "timestamp": "2025-05-20T13:31:33+02:00",
          "tree_id": "c35674d191d3ffbfd00437d4c450dcd1f4f51672",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/93b273c2a88afb69eef596e25da33a4d5b260268"
        },
        "date": 1747741019775,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3829458,
            "unit": "ns",
            "extra": "gctime=0\nmemory=821136\nallocs=19100\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 492444,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123856\nallocs=2749\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 35977370,
            "unit": "ns",
            "extra": "gctime=0\nmemory=13156888\nallocs=278054\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 3973675,
            "unit": "ns",
            "extra": "gctime=0\nmemory=939048\nallocs=21909\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 213269366,
            "unit": "ns",
            "extra": "gctime=7053071\nmemory=60552672\nallocs=1277567\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "844802a60e47ef67e7f7c9f98cc1eb04a261b37c",
          "message": "feat: bulk_multiplicity (#90)",
          "timestamp": "2025-05-20T15:16:16+02:00",
          "tree_id": "0051dd36b700d0b5c62e4ee85dffbb4dab5e4030",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/844802a60e47ef67e7f7c9f98cc1eb04a261b37c"
        },
        "date": 1747747306073,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3822342,
            "unit": "ns",
            "extra": "gctime=0\nmemory=817664\nallocs=19056\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 493472.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123168\nallocs=2709\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 36774510,
            "unit": "ns",
            "extra": "gctime=0\nmemory=13365504\nallocs=279217\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4065173.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=941600\nallocs=21946\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 208697277,
            "unit": "ns",
            "extra": "gctime=6893774\nmemory=60616096\nallocs=1277867\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "72c8e247d52ea07973bf274b5a42c5b067294224",
          "message": "refactor: move set_reg_to_zero where the reguralisation enters (#93)",
          "timestamp": "2025-05-20T20:17:48+02:00",
          "tree_id": "21cf915e2d978ebd1e64f8c40840485eabd4f2eb",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/72c8e247d52ea07973bf274b5a42c5b067294224"
        },
        "date": 1747765393919,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3805605,
            "unit": "ns",
            "extra": "gctime=0\nmemory=826456\nallocs=18968\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 524695,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123496\nallocs=2727\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 39057669,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16297008\nallocs=319000\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4081283,
            "unit": "ns",
            "extra": "gctime=0\nmemory=945840\nallocs=21850\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 212435504,
            "unit": "ns",
            "extra": "gctime=7703766\nmemory=62399752\nallocs=1289880\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "9d5841cde147c34d72df82142d21f96e36b8f0bf",
          "message": "feat: canonicalize (#92)",
          "timestamp": "2025-05-21T08:37:09+02:00",
          "tree_id": "7f12c176a940b9fd89f5bc0133dbacc77b374290",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/9d5841cde147c34d72df82142d21f96e36b8f0bf"
        },
        "date": 1747809754087,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3897463,
            "unit": "ns",
            "extra": "gctime=0\nmemory=880312\nallocs=19990\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 508992.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=123248\nallocs=2717\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 34134573,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14958824\nallocs=297335\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4358334,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1015144\nallocs=23189\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 199499862,
            "unit": "ns",
            "extra": "gctime=5789376\nmemory=57867240\nallocs=1237756\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "227a84bc0378f663469bc50708040f2c3e316762",
          "message": "feat: add bulk_multiplicity check (#95)",
          "timestamp": "2025-05-21T14:14:24+02:00",
          "tree_id": "9ebe466e4dc432b344674920a0fa6875aa90c544",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/227a84bc0378f663469bc50708040f2c3e316762"
        },
        "date": 1747829990772,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 3795913,
            "unit": "ns",
            "extra": "gctime=0\nmemory=881616\nallocs=20000\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 624320,
            "unit": "ns",
            "extra": "gctime=0\nmemory=148448\nallocs=3346\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 34360321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15013792\nallocs=297685\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4210710,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1012544\nallocs=23152\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 197388298.5,
            "unit": "ns",
            "extra": "gctime=5837743.5\nmemory=58033584\nallocs=1239225\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "09a7ecacf8b819cbe00a05b84310a3977b4429e9",
          "message": "refactor: add propagation sorting and print functionality in elastic_two_body example (#96)",
          "timestamp": "2025-05-21T15:08:46+02:00",
          "tree_id": "b2e6af31c1c84baeae4c12c73eab2e1939c7a744",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/09a7ecacf8b819cbe00a05b84310a3977b4429e9"
        },
        "date": 1747833255459,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 4090354.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=877464\nallocs=19958\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 621698,
            "unit": "ns",
            "extra": "gctime=0\nmemory=148336\nallocs=3336\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 36677837,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15037552\nallocs=297796\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 4332291,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1011448\nallocs=23148\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 206946277,
            "unit": "ns",
            "extra": "gctime=6439201\nmemory=58013368\nallocs=1238645\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "cfb9cd4e306d13160db0eaf1a27d088c52dc50ba",
          "message": "refactor: replace Symbolic Propagator with Diagram Struct (#97)",
          "timestamp": "2025-05-23T08:56:20+02:00",
          "tree_id": "601a022ac939abf1bd5233ec802bf3cad6c5b713",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/cfb9cd4e306d13160db0eaf1a27d088c52dc50ba"
        },
        "date": 1747983715943,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 622128,
            "unit": "ns",
            "extra": "gctime=0\nmemory=246640\nallocs=4773\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 75252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=35472\nallocs=849\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 14881321.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9759120\nallocs=170363\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 741692,
            "unit": "ns",
            "extra": "gctime=0\nmemory=288096\nallocs=5589\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 94869302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25370512\nallocs=436387\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "d3d593a0fa34821bee50128a8ad3ccd4d78bb2ea",
          "message": "refactor: make concrete (#99)",
          "timestamp": "2025-05-23T11:35:20+02:00",
          "tree_id": "a23d499d96a75b6bf0493c7856d4f89f1051bc71",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/d3d593a0fa34821bee50128a8ad3ccd4d78bb2ea"
        },
        "date": 1747993216880,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 661537,
            "unit": "ns",
            "extra": "gctime=0\nmemory=247728\nallocs=4804\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 66995,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 15588614,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9755712\nallocs=170182\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 769789,
            "unit": "ns",
            "extra": "gctime=0\nmemory=289088\nallocs=5614\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 95849645,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25350736\nallocs=435263\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "9e550933b59c5b0a46c505769da8cc656114c664",
          "message": "refactor: reduce JET warnings (#100)",
          "timestamp": "2025-05-23T13:25:32+02:00",
          "tree_id": "082b2b61c8fef02471cd23774849e20bed67aab5",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/9e550933b59c5b0a46c505769da8cc656114c664"
        },
        "date": 1747999832031,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 609667,
            "unit": "ns",
            "extra": "gctime=0\nmemory=260336\nallocs=4873\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 65201,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 16823458.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14313424\nallocs=244024\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 712258.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=291104\nallocs=5479\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 93941152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=27325072\nallocs=459041\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "fa98a6bcfa2541e1af8761b6dfb8aa1423242bf6",
          "message": "test: fix two-boson loss tests (#101)",
          "timestamp": "2025-05-23T19:07:10+02:00",
          "tree_id": "6a10c6c26832ff8a55517dba727140a7f64eb76c",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/fa98a6bcfa2541e1af8761b6dfb8aa1423242bf6"
        },
        "date": 1748020326165,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 594668.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=262544\nallocs=4960\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 64550,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 16679667,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14350464\nallocs=244926\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 717633,
            "unit": "ns",
            "extra": "gctime=0\nmemory=293504\nallocs=5572\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 95931372,
            "unit": "ns",
            "extra": "gctime=0\nmemory=27454880\nallocs=462653\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "fae07aec9af53a3d9631c661a254e5c9613ae64f",
          "message": "refactor: cleanup and TODO's (#102)",
          "timestamp": "2025-05-23T19:18:08+02:00",
          "tree_id": "7379fd629d09102b1c21350eb71fba437c8e3d54",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/fae07aec9af53a3d9631c661a254e5c9613ae64f"
        },
        "date": 1748020984207,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 597625,
            "unit": "ns",
            "extra": "gctime=0\nmemory=262544\nallocs=4960\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 66203,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 16820823,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14353888\nallocs=244974\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 714180,
            "unit": "ns",
            "extra": "gctime=0\nmemory=293504\nallocs=5572\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 93713605.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=27454880\nallocs=462653\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "122c69e987769bde74f10217e693f35a710475de",
          "message": "fix: simplify complex (#103)",
          "timestamp": "2025-05-24T13:05:19+02:00",
          "tree_id": "b708b5c2d2d4514657dbb218d0eb90a5f0a3e992",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/122c69e987769bde74f10217e693f35a710475de"
        },
        "date": 1748085020870,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 609328.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=262544\nallocs=4960\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 64320,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 17022261.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14350464\nallocs=244926\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 728862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=293504\nallocs=5572\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 96560935,
            "unit": "ns",
            "extra": "gctime=0\nmemory=27454880\nallocs=462653\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
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
          "id": "cbefc4a1bb4282921ddba93cacf5bc319340c07a",
          "message": "fix: another Jet fix (#104)",
          "timestamp": "2025-05-24T13:56:24+02:00",
          "tree_id": "3d9b6a9041178e0eded765f7b98ed29e12377529",
          "url": "https://github.com/oameye/KeldyshContraction.jl/commit/cbefc4a1bb4282921ddba93cacf5bc319340c07a"
        },
        "date": 1748088077289,
        "tool": "julia",
        "benches": [
          {
            "name": "Two body loss/Green's function",
            "value": 576648,
            "unit": "ns",
            "extra": "gctime=0\nmemory=262544\nallocs=4960\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Self-energy",
            "value": 64510,
            "unit": "ns",
            "extra": "gctime=0\nmemory=31936\nallocs=769\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body loss/Green's function second order",
            "value": 16339430,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14350464\nallocs=244926\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function",
            "value": 694529,
            "unit": "ns",
            "extra": "gctime=0\nmemory=293504\nallocs=5572\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":10,\"overhead\":0,\"memory_tolerance\":0.01}"
          },
          {
            "name": "Two body scattering/Green's function second order",
            "value": 93786860.5,
            "unit": "ns",
            "extra": "gctime=0\nmemory=27454880\nallocs=462653\nparams={\"gctrial\":true,\"time_tolerance\":0.05,\"evals_set\":false,\"samples\":10000,\"evals\":1,\"gcsample\":false,\"seconds\":50,\"overhead\":0,\"memory_tolerance\":0.01}"
          }
        ]
      }
    ]
  }
}