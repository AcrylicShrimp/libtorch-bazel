def _impl(ctx):
    libtorch = ctx.download_and_extract(url = select({
        "@bazel_tools//src/conditions:windows": "https://download.pytorch.org/libtorch/cpu/libtorch-win-shared-with-deps-1.4.0.zip",
        "@bazel_tools//src/conditions:darwin": "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.4.0.zip",
        "//conditions:default": "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.4.0%2Bcpu.zip",
    }), output = "libtorch", sha256 = select({
        "@bazel_tools//src/conditions:windows": "704a220f0bf06b6f870eb14f6c692c77b948475f4342cfe0efd551965e8cab26",
        "@bazel_tools//src/conditions:darwin": "84e9112b442ee1e3dc9e078d9066a855a2344ec566616cffbff1662e08cd8bf7",
        "//conditions:default": "33a9dd142d0497375db42b055bd90780f9d92047a19edc8891e6232e2b5bdba7",
    }))

    ctx.file("WORKSPACE", content = "")
    ctx.file("BUILD", content = """
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name="main",
    hdrs=glob(["libtorch/include/"]),
    srcs="libtorch/lib/" + select({
        "@bazel_tools//src/conditions:windows": "torch.dll",
        "@bazel_tools//src/conditions:darwin": "libtorch.dylib",
        "//conditions:default": "libtorch.so",
    }),
    strip_include_prefix="libtorch/include",
    copts=["-Itorch/csrc/api/include"]
)
    """)

libtorch = repository_rule(implementation = _impl)
