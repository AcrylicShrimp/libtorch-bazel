load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "main",
    srcs = "@dev_ashrimp_libtorch_bazel//libtorch/lib/" + select({
        "@bazel_tools//src/conditions:windows": "torch.dll",
        "@bazel_tools//src/conditions:darwin": "libtorch.dylib",
        "//conditions:default": "libtorch.so",
    }),
    hdrs = glob(["dev_ashrimp_libtorch_bazel//libtorch/include/**/*.h"]),
    copts = ["-I@dev_ashrimp_libtorch_bazel//torch/csrc/api/include"],
    strip_include_prefix = "@dev_ashrimp_libtorch_bazel//libtorch/include",
)
