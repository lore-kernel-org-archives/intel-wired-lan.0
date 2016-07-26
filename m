From: Jarod Wilson <jarod@redhat.com>
Date: Tue, 26 Jul 2016 14:25:33 -0400
Subject: [Intel-wired-lan] [PATCH v3 net-next 0/2] e1000e: fix PTP on
	e1000_pch_variants
In-Reply-To: <1469292274-59237-1-git-send-email-jarod@redhat.com>
References: <1469292274-59237-1-git-send-email-jarod@redhat.com>
Message-ID: <1469557535-63429-1-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This little series factors out the systim sanitization code first, then
adds e1000_pch_lpt as a new case in the switch that calls the sanitize
function, fixing PTP clock issues I've had reported against an Intel
I-218V NIC in an Intel NUC5ik5RYH system.

Jarod Wilson (2):
  e1000e: factor out systim sanitization
  e1000e: fix PTP on e1000_pch_lpt variants

Note: this series replaces the previously submitted singleton patch that
was, er, broken, titled the same.

v3: set and use feature flag to decide to call sanitize function

Reported-by: Rupesh Patel <rupatel@redhat.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: intel-wired-lan at lists.osuosl.org
CC: netdev at vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>

 drivers/net/ethernet/intel/e1000e/netdev.c | 72 +++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 27 deletions(-)

-- 
1.8.3.1

