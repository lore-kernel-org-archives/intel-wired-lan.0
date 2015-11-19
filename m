From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Nov 2015 22:14:15 +0000
Subject: [Intel-wired-lan] [next-queue, v2,
 2/8] e1000: fix a typo in the comment
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D757@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jean Sacren <sakiwit@gmail.com>
> 
> Use 'That' to replace 'The' so that the comment would make sense.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes.
>
> drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
>

> 1 file changed, 1 insertion(+), 1 deletion(-)

I would prefer the 2 spaces at the end of the period be kept with the comment change for the simple reason that the majority of comments in this file that have  sentence end and another start up on the same line have 2 spaces.  But not all, so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
