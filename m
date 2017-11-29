From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Nov 2017 02:12:57 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Alert the user that
 C-states will be disabled by enabling jumbo frames
In-Reply-To: <20171114235133.14755-1-mattst88@gmail.com>
References: <20171107221332.28283-2-mattst88@gmail.com>
 <20171114235133.14755-1-mattst88@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6F2757@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Matt Turner
> Sent: Tuesday, November 14, 2017 3:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Turner, Matt <matt.turner@intel.com>
> Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Alert the user that C-states will
> be disabled by enabling jumbo frames
> 
> From: Matt Turner <matt.turner@intel.com>
> 
> I personally spent a long time trying to decypher why my CPU would not
> reach deeper C-states. Let's just tell the next user what's going on.
> 
> Signed-off-by: Matt Turner <matt.turner@intel.com>
> ---
> v2: Per Shannon, put string on one line for easier grepping
> 
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
