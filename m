From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 18:10:02 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ethtool: correct VF index values
 for the ring_cookie parameter
In-Reply-To: <20171110185553.14657-3-jacob.e.keller@intel.com>
References: <20171110185553.14657-1-jacob.e.keller@intel.com>
 <20171110185553.14657-3-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEDDF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, November 10, 2017 10:56 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 3/3] ethtool: correct VF index values for
> the ring_cookie parameter
> 
> Instead of relying on the input being offset by 1, instead adjust the "vf" input
> value by 1 so that it correctly targets the VF the user expects. Additionally,
> update the displayed output to show the correct VF number.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> This is the way the VF parameter should have worked from the beginning,
> but unfortunately I did not code it as such. It may be considered a functional
> change (since we already supported the vf parameter with the offset not
> handled properly). I would consider this a bug fix, but it might be considered
> a behavior change....
> 
>  ethtool.8.in |  3 +--
>  rxclass.c    | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


