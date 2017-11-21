aws support describe-trusted-advisor-checks --language en --query "checks[?category=='cost_optimizing'].[id,name]" --output text | sort -k2
