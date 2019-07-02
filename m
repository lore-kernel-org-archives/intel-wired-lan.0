From: David Miller <davem@davemloft.net>
Date: Tue, 02 Jul 2019 11:06:42 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] iavf: remove unused debug
 function iavf_debug_d
In-Reply-To: <20190702062021.41524-1-yuehaibing@huawei.com>
References: <20190702062021.41524-1-yuehaibing@huawei.com>
Message-ID: <20190702.110642.1497627672189280557.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 2 Jul 2019 14:20:21 +0800

> There is no caller of function iavf_debug_d() in tree since
> commit 75051ce4c5d8 ("iavf: Fix up debug print macro"),
> so it can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Jeff, please queue this up or handle however is otherwise appropriate.

Thanks.
