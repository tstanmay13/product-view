#!/usr/bin/env bash
# Illustrative demo of the `product-view` skill — representative example output,
# rendered by assets/demo.tape via VHS. Not a transcript of a single live run.
set -u

ESC=$'\033'
RESET="${ESC}[0m"; BOLD="${ESC}[1m"; DIM="${ESC}[2m"
CYAN="${ESC}[38;5;117m"; GREEN="${ESC}[38;5;150m"
GREY="${ESC}[38;5;245m"; WHITE="${ESC}[38;5;231m"

type_out() { local s="$1" i; for (( i=0; i<${#s}; i++ )); do printf '%s' "${s:$i:1}"; sleep 0.03; done; }
line() { printf '%b\n' "$1"; sleep 0.32; }

clear
sleep 0.4
printf "${GREY}~/checkout · claude code${RESET}\n\n"
sleep 0.5

printf "${GREEN}>${RESET} ${WHITE}"
type_out "this Sentry alert fired overnight — what's broken for customers?"
printf "${RESET}\n"
sleep 0.4
line "  ${DIM}TypeError: Cannot read properties of null (reading 'address')${RESET}"
line "  ${DIM}  at CheckoutShipping.computeTax (CheckoutShipping.tsx:142)${RESET}"
line "  ${DIM}1,247 sessions in 24h · Browsers: Safari iOS (98%)${RESET}"
printf "\n"
sleep 0.7

printf "${CYAN}⏺ product-view${RESET}\n\n"
sleep 0.5

line "  Shoppers on iPhones can't finish buying. The moment they"
line "  enter their shipping address, the page stalls — the total"
line "  breaks and they can't get to payment."
printf "\n"; sleep 0.2
line "  About ${BOLD}1,250 people hit this yesterday${RESET}, nearly all on"
line "  iPhones, at the worst possible moment: ready to pay."
sleep 1.3
printf "\n"
printf "  ${GREY}— same alert, told from the customer's side. No stack trace.${RESET}\n"
sleep 2.2
