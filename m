From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2020 13:31:56 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
Message-ID: <20200915.133156.1580615428345209072.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 14 Sep 2020 18:44:45 -0700

> After applying the patches below, the drivers/net/ethernet
> directory can be built as modules with W=1 with no warnings (so
> far on x64_64 arch only!).
> As Jakub pointed out, there is much more work to do to clean up
> C=1, but that will be another series of changes.
> 
> This series removes 1,283 warnings and hopefully allows the
> ethernet directory to move forward from here without more
> warnings being added. There is only one objtool warning now.
> 
> Some of these patches are already sent to Intel Wired Lan, but
> the rest of the series titled drivers/net/ethernet affects other
> drivers. The changes are all pretty straightforward.
> 
> As part of testing this series I realized that I have ~1,500 more
> kdoc warnings to fix due to being in other arch or not compiled
> with my x86_64 .config. Feel free to run
> $ 'git ls-files *.[ch] | grep drivers/net/ethernet | xargs
> scripts/kernel-doc -none'
> to see the remaining issues.

Jesse, in all of these patches, I want to see the warning you are
fixing in the commit message.

Especially for the sh_eth.c one because I have no idea what the
compiler is actually warning about just by reading your commit
message and patch on it's own.

Thank you.
