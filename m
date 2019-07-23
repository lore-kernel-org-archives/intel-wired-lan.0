From: David Miller <davem@davemloft.net>
Date: Tue, 23 Jul 2019 13:03:24 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] i40e: Use dev_get_drvdata
In-Reply-To: <20190723141551.5857-1-hslester96@gmail.com>
References: <20190723141551.5857-1-hslester96@gmail.com>
Message-ID: <20190723.130324.990265277943408947.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 23 Jul 2019 22:15:51 +0800

> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.
