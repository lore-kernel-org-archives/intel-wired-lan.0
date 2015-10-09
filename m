From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 9 Oct 2015 13:28:57 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: re-use %*ph specifier to
	hexdump a data
In-Reply-To: <1443777496-43299-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443777496-43299-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <20151009132857.00002b95@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2 Oct 2015 12:18:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of using a custom approach change the code to use %*ph format
> specifier.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice catch, thanks!

Acked-by: jesse Brandeburg <jesse.brandeburg@intel.com>
