From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 15 Sep 2020 14:00:58 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200915.133156.1580615428345209072.davem@davemloft.net>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <20200915.133156.1580615428345209072.davem@davemloft.net>
Message-ID: <20200915140058.00007553@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

David Miller wrote:
> Jesse, in all of these patches, I want to see the warning you are
> fixing in the commit message.
> 
> Especially for the sh_eth.c one because I have no idea what the
> compiler is actually warning about just by reading your commit
> message and patch on it's own.

Ok, I'll respin with those added for the compiler warning fixes in
particular, and some simplified descriptions of the classes of kdoc
warnings.

