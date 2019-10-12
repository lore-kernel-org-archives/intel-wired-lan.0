From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 12 Oct 2019 11:31:09 -0700
Subject: [Intel-wired-lan] [net-next v3 5/7] igb: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-6-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-6-jacob.e.keller@intel.com>
Message-ID: <20191012183109.GF3165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 26, 2019 at 11:11:07AM -0700, Jacob Keller wrote:
> Fix the igb PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.

This HW always time stamps both edges:

  flags                                                 Meaning                   
  ----------------------------------------------------  -------------------------- 
  PTP_ENABLE_FEATURE                                    Time stamp both edges
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp both edges
  PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp both edges
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp both edges
 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Richard Cochran <richardcochran@gmail.com>
