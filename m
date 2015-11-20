From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:04:52 +0000
Subject: [Intel-wired-lan] [Next PATCH] e1000: make eeprom read/write
 scheduler friendly
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D9CE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Joern Engel <joern@logfs.org>
>
> Code was responsible for ~150ms scheduler latencies.
>
> Signed-off-by: Joern Engel <joern@logfs.org>
> Signed-off-by: Spencer Baugh <sbaugh@catern.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
