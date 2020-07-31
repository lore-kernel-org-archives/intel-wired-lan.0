From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 31 Jul 2020 10:49:08 +0300
Subject: [Intel-wired-lan] [PATCH v1] ice: devlink: use %*phD to print
 small buffer
In-Reply-To: <77247fbc-152a-517f-2500-ce761b7afa6a@intel.com>
References: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
 <77247fbc-152a-517f-2500-ce761b7afa6a@intel.com>
Message-ID: <20200731074908.GE3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 30, 2020 at 02:20:46PM -0700, Jacob Keller wrote:
> On 7/30/2020 9:04 AM, Andy Shevchenko wrote:
> > Use %*phD format to print small buffer as hex string.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Ah nice. I swear I looked for a printk format to do this and didn't find
> one. But it's been there since 2012.. so I guess I just missed it.

commit 31550a16a5d2af859e8a11839e8c6c6c9c92dfa7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Jul 30 14:40:27 2012 -0700

    vsprintf: add support of '%*ph[CDN]'

Maybe it was just a coincidence :-)

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> I also tested this on my system to make sure it gives the same output
> for the serial value, so I guess also:
> 
> Tested-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


