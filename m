From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Nov 2017 01:28:40 +0000
Subject: [Intel-wired-lan] [PATCH] e1000: Fix off-by-one in debug message
In-Reply-To: <20171118205358.29595-1-ahmad@a3f.at>
References: <20171118205358.29595-1-ahmad@a3f.at>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6F0D85@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Ahmad Fatoum
> Sent: Saturday, November 18, 2017 12:54 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Ahmad
> Fatoum <ahmad@a3f.at>
> Subject: [PATCH] e1000: Fix off-by-one in debug message
> 
> Signed-off-by: Ahmad Fatoum <ahmad@a3f.at>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
