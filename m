From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Wed, 16 Sep 2015 09:34:28 -0600
Subject: [Intel-wired-lan] [next-queue 1/8] e1000: clean up the useless
 'continue' statement
In-Reply-To: <9EC98ADF-EA6D-4BDC-A442-F42BB805FA84@intel.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
 <1442212070-24937-2-git-send-email-sakiwit@gmail.com>
 <32D3D43C-B677-4C70-8915-3B07B1175C66@intel.com>
 <20150915053501.GA3881@mail.gmail.com>
 <9EC98ADF-EA6D-4BDC-A442-F42BB805FA84@intel.com>
Message-ID: <20150916153428.GB3881@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Date: Tue, 15 Sep 2015 18:24:39 +0000
>
> > On Sep 14, 2015, at 10:35 PM, J?an Sacren <sakiwit@gmail.com> wrote:

[...]

> > The goto statement might be executed if and only if at the last loop out
> > of a total of 32. I think we need to rewrite the checking logic here:
> > 
> > 			...
> > 			if (tmp != 0 && tmp != 0xFF)
> > 				break;
> > 
> > 			if (i == 31)
> > 				goto err_eeprom;
> > 			...
> > 
> > What do you think?
> 
> This is ok too, but this makes it look to me like the if and goto
> should really be outside the loop, so after the loop one would have:
> 
> 		if (i == 32)
> 			goto err_eeprom;

I think moving the above check out of the loop is a good idea, yet it
still retains the same issue as doing the unnecessary checking.

How about the following patch:

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 74dc15055971..4c3ca7c9ce49 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1199,15 +1199,14 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		for (i = 0; i < 32; i++) {
 			hw->phy_addr = i;
 			e1000_read_phy_reg(hw, PHY_ID2, &tmp);
-			if (tmp == 0 || tmp == 0xFF) {
-				if (i == 31)
-					goto err_eeprom;
-				continue;
-			} else
-				break;
+
+			if (tmp != 0 && tmp != 0xFF)
+				goto no_err;
 		}
-	}
 
+		goto err_eeprom;
+	}
+no_err:
 	/* reset the hardware with the new settings */
 	e1000_reset(adapter);
 
