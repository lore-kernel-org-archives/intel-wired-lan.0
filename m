From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 3 Nov 2015 22:40:50 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't initialize
 fm10k_workqueue at global level
In-Reply-To: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
References: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC762DE@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Tuesday, November 03, 2015 11:35 AM
> To: Intel Wired LAN
> Cc: Allan, Bruce W; Keller, Jacob E
> Subject: [PATCH v2] fm10k: don't initialize fm10k_workqueue at global level
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Cleans up checkpatch GLOBAL_INITIALIZERS error
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> -v2
> * Fix title from checkpatch complaint

Out of curiosity, what was wrong with the original v1 patch title and what was the exact checkpatch complaint?

