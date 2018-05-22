From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 22 May 2018 23:02:48 +0000
Subject: [Intel-wired-lan] [PATCH] Documentation: e100: Update the Intel
 10/100 driver doc
In-Reply-To: <20180510192013.15363-1-jeffrey.t.kirsher@intel.com>
References: <20180510192013.15363-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964D2F23@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, May 10, 2018 12:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] Documentation: e100: Update the Intel
> 10/100 driver doc
> 
> Over the years, several of the links have changed or are no longer valid
> so update them.  In addition, the default values were incorrect for a
> couple of parameters.
> 
> Converted the text file to the reStructuredText (RST) format, since the
> Linux kernel documentation now uses this format for documentation.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  .../networking/{e100.txt => e100.rst}         | 60 +++++++++----------
>  Documentation/networking/index.rst            |  1 +
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 29 insertions(+), 34 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
