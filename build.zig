const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.build.Builder) void {
    const build_mode = b.standardReleaseOptions();
    const link_libc = b.option(bool, "libc", "Link libc") orelse false;
    const target = b.standardTargetOptions(null);

    const bench = b.addExecutable("bench", "bench.zig");
    bench.setBuildMode(build_mode);
    bench.setTheTarget(target);
    if (link_libc or (builtin.os != .windows and .os != .linux))
        bench.linkLibC();

    const step = b.step("bench", "Run the benchmark");
    step.dependOn(&bench.step);
    step.dependOn(&bench.run().step);
}