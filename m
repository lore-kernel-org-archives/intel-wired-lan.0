From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:05:57 -0400
Subject: [Intel-wired-lan]  [net-next S4 00/15] i40e/i40evf updates
Message-ID: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali adds ATR support for tunneled TCP/IPv4/IPv6 packets, stats to count
tunnel ATR hits, and stats to track flow director ATR and side band dynamic
enable state in i40e. She also removes some unnecessary members from the pf
struct and set the flow director ATR and side band messages to a higher debug
level.

Greg disables offline diagnostics if VFs are enabled, and removes an unnecessary
TODO comment in i40e.

Jesse makes some transmit functions inline to improve performance in both i40e
and i40evf. He also adds skb->xmit_more support to i40evf and removes
time_stamp member from i40e since it is not being used.

Mitch fixes i40evf to restore state properly when a netdev is closed and a reset
occurs.

Neerav fixes i40e to collect PFC XOFF RX stats even when there is a single TC.

Pawel updates device/function capabilities in i40e to include information needed
for Flex-10 configurations.

Vasu fixes an error case that should never be reached to WARN ON instead of
printing an error message.

-- 
1.9.3

