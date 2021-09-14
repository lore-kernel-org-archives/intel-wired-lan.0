From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Tue, 14 Sep 2021 13:42:10 +0300
Subject: [Intel-wired-lan] [PATCH] igc: fix tunnel offloading
In-Reply-To: <20210817131620.566614-1-vinschen@redhat.com>
References: <20210817131620.566614-1-vinschen@redhat.com>
Message-ID: <181feb46-eac6-8bd7-f75a-26d85b05da02@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/17/2021 16:16, Corinna Vinschen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Checking tunnel offloading, it turns out that offloading doesn't work
> as expected.  The following script allows to reproduce the issue.
> Call it as `testscript DEVICE LOCALIP REMOTEIP NETMASK'
> 
> === SNIP ===
> if [ $# -ne 4 ]
> then
>    echo "Usage $0 DEVICE LOCALIP REMOTEIP NETMASK"
>    exit 1
> fi
> DEVICE="$1"
> LOCAL_ADDRESS="$2"
> REMOTE_ADDRESS="$3"
> NWMASK="$4"
> echo "Driver: $(ethtool -i ${DEVICE} | awk '/^driver:/{print $2}') "
> ethtool -k "${DEVICE}" | grep tx-udp
> echo
> echo "Set up NIC and tunnel..."
> ip addr add "${LOCAL_ADDRESS}/${NWMASK}" dev "${DEVICE}"
> ip link set "${DEVICE}" up
> sleep 2
> ip link add vxlan1 type vxlan id 42 \
> 		   remote "${REMOTE_ADDRESS}" \
> 		   local "${LOCAL_ADDRESS}" \
> 		   dstport 0 \
> 		   dev "${DEVICE}"
> ip addr add fc00::1/64 dev vxlan1
> ip link set vxlan1 up
> sleep 2
> rm -f vxlan.pcap
> echo "Running tcpdump and iperf3..."
> ( nohup tcpdump -i any -w vxlan.pcap >/dev/null 2>&1 ) &
> sleep 2
> iperf3 -c fc00::2 >/dev/null
> pkill tcpdump
> echo
> echo -n "Max. Paket Size: "
> tcpdump -r vxlan.pcap -nnle 2>/dev/null \
> | grep "${LOCAL_ADDRESS}.*> ${REMOTE_ADDRESS}.*OTV" \
> | awk '{print $8}' | awk -F ':' '{print $1}' \
> | sort -n | tail -1
> echo
> ip link del vxlan1
> ip addr del ${LOCAL_ADDRESS}/${NWMASK} dev "${DEVICE}"
> === SNAP ===
> 
> The expected outcome is
> 
>    Max. Paket Size: 64904
> 
> This is what you see on igb, the code igc has been taken from.
> However, on igc the output is
> 
>    Max. Paket Size: 1516
> 
> so the GSO aggregate packets are segmented by the kernel before calling
> igc_xmit_frame.  Inside the subsequent call to igc_tso, the check for
> skb_is_gso(skb) fails and the function returns prematurely.
> 
> It turns out that this occurs because the feature flags aren't set
> entirely correctly in igc_probe.  In contrast to the original code
> from igb_probe, igc_probe neglects to set the flags required to allow
> tunnel offloading.
> 
> Setting the same flags as igb fixes the issue on igc.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>
