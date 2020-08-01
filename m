From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Sat, 1 Aug 2020 00:07:07 +0000
Subject: [Intel-wired-lan] [PATCH v1] ice: devlink: use %*phD to print
 small buffer
In-Reply-To: <20200731.164921.1194657794631782709.davem@davemloft.net>
References: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
 <20200731.164921.1194657794631782709.davem@davemloft.net>
Message-ID: <1e14e2bd97cc6e49d60acfa03ab1fa0c777a46ac.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2020-07-31 at 16:49 -0700, David Miller wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 30 Jul 2020 19:04:51 +0300
> 
> > Use %*phD format to print small buffer as hex string.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I am assuming the Intel folks will integrate this into their tree.

Yes, I'll take it into the Intel tree.
