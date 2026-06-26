# Makefile для NixOS CI
.PHONY: build-all check clean lint

HOST ?= nixos-homelab

VERBOSE ?= 0
ifeq ($(VERBOSE),1)
	NIX_FLAGS = --show-trace -L
else
	NIX_FLAGS = 
endif

# nix files lint
lint:
	@echo "Linting Nix files..."
	@find . -name "*.nix" -not -path "./result/*" -print0 | while IFS= read -r -d '' file; do \
		echo "Checking $$file..."; \
		nix-instantiate --parse "$$file" > /dev/null || exit 1; \
	done
	@echo "✅ Lint complete"

build-all:
	@echo "Building NixOS configuration: $(HOST)"
	nix build \
		$(NIX_FLAGS) \
		.#nixosConfigurations.$(HOST).config.system.build.toplevel \
		--print-build-logs
	@echo "✅ Build complete"

# flake check
check:
	@echo "Running flake check..."
	nix flake check $(NIX_FLAGS)
	@echo "✅ Flake check passed"

# cleanup
clean:
	@echo "Cleaning up Nix store..."
	nix-collect-garbage -d
	@echo "✅ Cleanup complete"

build-all-hosts:
	@echo "🔨 Building all NixOS configurations..."
	@for host in $$(nix eval --json .#nixosConfigurations | jq -r 'keys[]'); do \
		echo "Building $$host..."; \
		nix build .#nixosConfigurations.$$host.config.system.build.toplevel || exit 1; \
	done
	@echo "✅ All builds complete"

info:
	@echo "Configuration info:"
	@echo "Host: $(HOST)"
	@echo "Nix version: $$(nix --version)"
	@echo "Available configurations:"
	@nix eval .#nixosConfigurations --apply 'builtins.attrNames'
