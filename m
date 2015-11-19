From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Nov 2015 22:23:01 +0000
Subject: [Intel-wired-lan] :  [next-queue, v2,
 8/8] e1000: get rid of duplicate exit path
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D7AE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jean Sacren <sakiwit@gmail.com>
>
> By using goto statement, we can achieve sharing the same exit path so
> that code duplication could be minimized.
>
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes.
>
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
