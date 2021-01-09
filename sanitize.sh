#!/bin/bash
#Sanitizes filenames and directory names for MS windows systems
#Crude, nude and rude - this is an initial version that can and will trash your system if invoked by mistake!
#Do not use this unless you are sure you won't ever make a mistake
cd "$1"
echo -e "Directory: $(pwd)\n"
workdir="$(pwd)"

echo "Check for missing album art?"
read -n1 -s -p "Continue [y/n]" yesno
echo ""

if [[ "$yesno" = "y" ]]; then
	find "$workdir" -mindepth 2 -type d | while read dir; do
		if [ ! -e "${dir}/cover.jpg" ]; then
			echo "$dir"
		fi
	done
fi
echo ""

read -n1 -s -p "Replace double quotes? ( \" ) [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "*[\"]*" | while read file; do
		y=$(sed 's/[\"]//g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*\"*" | while read dir; do
		y=$(sed 's/[\"]//g' <<< "$dir"); mv "$dir" "$y"
	done
fi
echo ""

read -n1 -s -p "Replace trailing periods? ( . ) [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "*[.]" | while read file; do
		y=$(sed 's/[.]*$//g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*[.]" | while read dir; do
		y=$(sed 's/[.]*$//g' <<< "$dir"); mv "$dir" "$y"
	done
fi
echo ""

read -n1 -s -p "Replace colons and commas? ( :, ) [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "*[:,]*" | while read file; do
		y=$(sed 's/[:,]//g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*[:,]*" | while read dir; do
		y=$(sed 's/[:,]//g' <<< "$dir"); mv "$dir" "$y"
	done
fi
echo ""

read -n1 -s -p "Replace various special chars? ( <>\\|?* ) [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "*[<>\\|?*]*" | while read file; do
		y=$(sed 's/[<>\\|?*]//g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*[<>\\|?*]*" | while read dir; do
		y=$(sed 's/[<>\\|?*]//g' <<< "$dir"); mv "$dir" "$y"
	done
fi
echo ""

read -n1 -s -p "Replace ampersand? ( & ) [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "* [&] *" | while read file; do
		y=$(sed 's/[&]/and/g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "* [&] *" | while read dir; do
		y=$(sed 's/[&]/and/g' <<< "$dir"); mv "$dir" "$y"
	done

	find "$workdir" -type f -name "*[&]*" | while read file; do
		y=$(sed 's/[&]/ and /g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*[&]*" | while read dir; do
		y=$(sed 's/[&]/ and /g' <<< "$dir"); mv "$dir" "$y"
	done
fi
echo ""

read -n1 -s -p "Replace double whitespaces? [y/n]" yesno
echo ""
if [[ "$yesno" = "y" ]]; then
	find "$workdir" -type f -name "*\ \ *" | while read file; do
		y=$(sed 's/\ \ / /g' <<< "$file"); mv "$file" "$y"
	done
	find "$workdir" -mindepth 1 -type d -name "*\ \ *" | while read dir; do
		y=$(sed 's/\ \ / /g' <<< "$dir"); mv "$dir" "$y"
	done
fi
cd - 2>&1 > /dev/null
