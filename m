From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:23:13 +0000
Subject: [Intel-wired-lan] [Next PATCH] e1000_hw.c_Elementary checkpatch
 warnings and checks removed
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3DA27@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Janusz Wolak <januszvdm@gmail.com>
> Date: Mon, 28 Sep 2015 23:40:19 +0200
> Subject: [PATCH 2/2] Elementary checkpatch warnings and checks removed.
> 
> Signed-off-by: Janusz Wolak <januszvdm@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 181 ++++++++++++++--------------
>  1 file changed, 90 insertions(+), 91 deletions(-)

Checkpatch gives a handful of over 80 column warnings, which is a bit ironic for a checkpatch cleanup patch, but the long lines are pre-existing, so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
