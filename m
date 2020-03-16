From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 20:32:12 +0000
Subject: [Intel-wired-lan] [PATCH 2/7] i40e: Use scnprintf() for
 avoiding potential buffer overflow
In-Reply-To: <20200311083745.17328-3-tiwai@suse.de>
References: <20200311083745.17328-1-tiwai@suse.de>
 <20200311083745.17328-3-tiwai@suse.de>
Message-ID: <92500904ba1a4c91b5a1215d12266234@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Takashi Iwai
Sent: Wednesday, March 11, 2020 1:38 AM
To: netdev@vger.kernel.org
Cc: intel-wired-lan at lists.osuosl.org; David S . Miller <davem@davemloft.net>
Subject: [Intel-wired-lan] [PATCH 2/7] i40e: Use scnprintf() for avoiding potential buffer overflow

Since snprintf() returns the would-be-output size instead of the actual output size, the succeeding calls may go beyond the given buffer limit.  Fix it by replacing with scnprintf().

Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


