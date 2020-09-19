From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Sep 2020 07:23:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests: net: add a
 test for shared UDP tunnel info tables
In-Reply-To: <20200722012716.2814777-5-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-5-kuba@kernel.org>
Message-ID: <SN6PR11MB2896F5ACC5A59F7F330183FFBC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jakub
> Kicinski
> Sent: Tuesday, July 21, 2020 6:27 PM
> To: davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Jakub Kicinski
> <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests: net: add a test for
> shared UDP tunnel info tables
> 
> Add a test run of checks validating the shared UDP tunnel port
> tables function as we expect.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
I ran into two things while running this script.
1. The script as it exists in the git tree (Jeff Kirshers next-queue) is not executable.  I don't know if that's a patch issue or translation into the tree.  Easy enough to get around, but should probably be executable to start.

2. The script runs into a handful of errors,7 to be precise.  I'm not sure if they are real failures, incorrect expectations or maybe something in my kernel .config (I have been using a minimal .config and enabling modules as needed.)

The output I get from it is:
----------------------------------------------------------------------------------------------------
u1518:[0]/usr/src/kernels/next-queue> cat ~/udp_tunnel-sh-outut.txt                                                                     
ERROR: table 0 on port 1: basic - VxLAN v4 devices
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 0 on port 1: basic - VxLAN v4 devices
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 0 on port 1: basic - VxLAN v6 devices
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 0 on port 1: basic - VxLAN v6 devices
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 0 on port 1: basic - another VxLAN v6 devices
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 0 on port 1: basic - Geneve device
       check_table: wrong entry 0
       expected: port: 4789     type: 1
       have:     port: 0        type: 0
ERROR: table 1 on port 1: basic - Geneve device
       check_table: wrong entry 0
       expected: port: 6081     type: 2
       have:     port: 0        type: 0
FAILED 7/435 checks
u1518:[0]/usr/src/kernels/next-queue>
----------------------------------------------------------------------------------------------------
The script sends messages to dmesg, most look to be informative "set" and "unset" messages, but I do get a handful of failed messages.  The dmesg queue was cleared before the run so only contains the udp_tunnel-sh messages:
----------------------------------------------------------------------------------------------------
u1518:[0]/usr/src/kernels/next-queue> dmesg|grep -i fail
[ 8909.179462] netdevsim netdevsim386 eth4: UDP tunnel port sync failed port 10000 type vxlan: -110
[ 8909.328763] netdevsim netdevsim386 eth4: UDP tunnel port sync failed port 20000 type geneve: -2
[ 8909.444028] netdevsim netdevsim386 eth4: UDP tunnel port sync failed port 10000 type vxlan: -110
[ 8909.592049] netdevsim netdevsim386 eth4: UDP tunnel port sync failed port 20000 type geneve: -2
u1518:[0]/usr/src/kernels/next-queue>
