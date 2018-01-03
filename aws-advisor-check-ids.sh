aws support describe-trusted-advisor-checks --region us-east-1 --language en --query "checks[?category=='cost_optimizing'].[id,name]" --output text | sort -k2
