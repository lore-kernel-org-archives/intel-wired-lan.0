From: David Miller <davem@davemloft.net>
Date: Fri, 31 Jul 2020 16:49:21 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH v1] ice: devlink: use %*phD to print
 small buffer
In-Reply-To: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
References: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20200731.164921.1194657794631782709.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Jul 2020 19:04:51 +0300

> Use %*phD format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I am assuming the Intel folks will integrate this into their tree.
