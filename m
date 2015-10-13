From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 13 Oct 2015 16:12:22 +0000
Subject: [Intel-wired-lan] [PATCH v8 2/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05F28E7A@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05F28E7A@BPXM14GP.gisp.nec.co.jp>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271E74BC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Hiroshi Shimamoto
Sent: Thursday, August 27, 2015 11:59 PM
To: Or Gerlitz <gerlitz.or@gmail.com>; Alexander Duyck <alexander.duyck@gmail.com>; Skidmore, Donald C <donald.c.skidmore@intel.com>; Rose, Gregory V <gregory.v.rose@intel.com>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org; nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List <netdev@vger.kernel.org>; Choi, Sy Jong <sy.jong.choi@intel.com>; Rony Efraim <ronye@mellanox.com>; Edward Cree <ecree@solarflare.com>; David Miller <davem@davemloft.net>; sassmann at redhat.com
Subject: [Intel-wired-lan] [PATCH v8 2/3] ixgbe: Add new ndo to trust VF

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Implements the new netdev op to trust VF in ixgbe.

The administrator can turn on and off VF trusted by ip command which supports trust message.
 # ip link set dev eth0 vf 1 trust on
or
 # ip link set dev eth0 vf 1 trust off

Send a ping to reset VF on changing the status of trusting.
VF driver will reconfigure its features on reset.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


