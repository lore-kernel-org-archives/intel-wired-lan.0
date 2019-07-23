From: David Miller <davem@davemloft.net>
Date: Tue, 23 Jul 2019 13:03:29 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] igb: Use dev_get_drvdata where
 possible
In-Reply-To: <20190723141624.5911-1-hslester96@gmail.com>
References: <20190723141624.5911-1-hslester96@gmail.com>
Message-ID: <20190723.130329.976054867944575896.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 23 Jul 2019 22:16:24 +0800

> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.
