From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 27 Jan 2021 23:37:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: remove redundant null
 check on pf
In-Reply-To: <1611748244-20592-1-git-send-email-wangyunjian@huawei.com>
References: <1611748244-20592-1-git-send-email-wangyunjian@huawei.com>
Message-ID: <f8a08a517fbe6977c1777c77067d800d0bbbc9ad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-01-27 at 19:50 +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Before calling ice_set_dflt_mib(), the 'pf' has been dereferenced.
> So the additional check is unnecessary, just remove it.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 7d9c9b791f9e ("ice: Implement LFC workaround")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---

Thanks for the patch Yunjian. However, we do have a patch coming[1]
that fixes this issue.

Thanks,
Tony

[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/patch/20201012225326.15722-1-anthony.l.nguyen at intel.com/
