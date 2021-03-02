From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 2 Mar 2021 01:37:59 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: use proper #include guard
 name in hw.h
In-Reply-To: <20210227095858.604463-1-gregkh@linuxfoundation.org>
References: <20210227095858.604463-1-gregkh@linuxfoundation.org>
Message-ID: <df502c9f145e8ca26d7c79f291fc7abd48066b88.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-02-27 at 10:58 +0100, Greg Kroah-Hartman wrote:
> The include guard for the e1000e and e1000 hw.h files are the same,
> so
> add the proper "E" term to the hw.h file for the e1000e driver.

There's a patch in process that addresses this issue [1].

> This resolves some static analyzer warnings, like the one found by
> the
> "lgtm.com" tool.
> 
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: intel-wired-lan at lists.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/patch/20210222040005.20126-1-tseewald at gmail.com/

Thanks,
Tony
