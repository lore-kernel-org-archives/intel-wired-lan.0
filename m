From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 26 Mar 2015 21:17:58 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] ixgbe: Add the
 appropriate ethtool ops to query RSS indirection table and key
In-Reply-To: <1427409886-20261-1-git-send-email-vladz@cloudius-systems.com>
References: <1427409886-20261-1-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427429878.2497.46.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-03-27 at 00:44 +0200, Vlad Zolotarov wrote:
> Add the ethtool ops to VF driver to allow querying the RSS indirection
> table
> and RSS Random Key.
> 
> This series refactors the RSS configuration code to store the current
> contents of
> RSS indirection table and Hash Key in the "adapter" struct so that we
> won't need
> to access registers every time this info is queried.
> 
> New in v2:
>    - Some styling fixes.
>    - Moved macros definitions from ixgbe_type.h to ixgbe.h.
> 
> Vlad Zolotarov (2):
>   ixgbe: Refactor the RSS configuration code.
>   ixgbe: Add the appropriate ethtool ops to query RSS indirection
> table
>     and key

I am assuming that this series is to replace the latest v8 series,
correct?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150326/4d0c9ca1/attachment.asc>
