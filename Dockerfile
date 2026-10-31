# ---- 构建阶段 ----
FROM gcc:12 AS build
RUN apt-get update \
    && apt-get install -y --no-install-recommends cmake make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
# 关键修改：通过 CMAKE_EXE_LINKER_FLAGS 传递静态链接选项
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --target app -j

# ---- 运行阶段 ----
FROM debian:bookworm-slim
RUN apt-get update \
    && apt-get install -y --no-install-recommends libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/build/app /app/app
CMD ["/app/app"]