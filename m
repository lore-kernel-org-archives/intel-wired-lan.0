From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 8 Mar 2022 09:34:43 -0800
Subject: [Intel-wired-lan] [PATCH net-next] ice: gnss: fix a NULL vs
 IS_ERR() check
In-Reply-To: <20220307141746.GD18867@kili>
References: <20220307141746.GD18867@kili>
Message-ID: <0398de5e-2f3d-d82e-efa4-2f723e8f4276@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Dan,

On 3/7/2022 6:17 AM, Dan Carpenter wrote:
> The tty_alloc_driver() function returns error pointers, it never returns
> NULL.

We already have a fix patch that also addresses another of the same issue.

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220305090430.3078757-1-yangyingliang at huawei.com/

Thanks,

Tony

> Fixes: 43113ff73453 ("ice: add TTY for GNSS module for E810T device")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
