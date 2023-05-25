set -e
git clone --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd /linux/tools/perf
make
cp perf /usr/bin
