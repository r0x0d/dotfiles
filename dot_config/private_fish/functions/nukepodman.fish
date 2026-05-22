function nukepodman
    podman image prune --all --external
    podman system reset
end
