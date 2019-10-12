From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 12 Oct 2019 11:36:32 -0700
Subject: [Intel-wired-lan] [net-next v3 6/7] mlx5: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-7-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-7-jacob.e.keller@intel.com>
Message-ID: <20191012183632.GG3165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 26, 2019 at 11:11:08AM -0700, Jacob Keller wrote:
> Fix the mlx5 core PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.

I'm not 100% sure what this driver does, but if I'm not wrong it
follows the dp83640:

  flags                                                 Meaning
  ----------------------------------------------------  --------------------------
  PTP_ENABLE_FEATURE                                    Time stamp rising edge
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp rising edge
  PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp falling edge
  PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp falling edge

> Cc: Feras Daoud <ferasda@mellanox.com>
> Cc: Eugenia Emantayev <eugenia@mellanox.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Richard Cochran <richardcochran@gmail.com>
