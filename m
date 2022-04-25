From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon, 25 Apr 2022 08:27:54 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/2] ice: preventing VLAN
 configuration in switchdev
Message-ID: <20220425062756.14987-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In switchdev for any VLAN configuration requested from VF PF should
answer with not supported error. Instead of adding custom ops for all
VLAN ops prevent setting VLAN VF caps.

Thanks for that ugly error from dmesg will be removed as VF should not
send VLAN configuration commands. If it sends any PF driver will
return not supported error because all VLAN opcodes are remove from
allowlist (only in switchdev mode).

Michal Swiatkowski (2):
  ice: don't set VF VLAN caps in switchdev
  ice: remove VLAN representor specific ops

 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 121 ++++++++----------
 1 file changed, 54 insertions(+), 67 deletions(-)

-- 
2.31.1

