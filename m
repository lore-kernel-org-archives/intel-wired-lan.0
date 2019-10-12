From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 12 Oct 2019 11:28:56 -0700
Subject: [Intel-wired-lan] [net-next v3 4/7] dp83640: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-5-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-5-jacob.e.keller@intel.com>
Message-ID: <20191012182856.GE3165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 26, 2019 at 11:11:06AM -0700, Jacob Keller wrote:
> Fix the dp83640 PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.

This driver has:

  flags                                                 Meaning                   
  ----------------------------------------------------  -------------------------- 
  PTP_ENABLE_FEATURE                                    Time stamp rising edge
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp rising edge
  PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp falling edge
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp falling edge
 
> Cc: Stefan S?rensen <stefan.sorensen@spectralink.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Richard Cochran <richardcochran@gmail.com>
