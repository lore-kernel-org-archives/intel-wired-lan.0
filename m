From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 4 Sep 2017 18:25:55 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: changed some expensive calls
 of udelay to usleep_range
In-Reply-To: <1503503985-3869-1-git-send-email-matthew.tan_1@nxp.com>
References: <1503503985-3869-1-git-send-email-matthew.tan_1@nxp.com>
Message-ID: <20170904162555.GB21849@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

> @@ -183,7 +183,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>  	 * reading duplicate data in the next MDIC transaction.
>  	 */
>  	if (hw->mac.type == e1000_pch2lan)
> -		udelay(100);
> +		usleep_range(90, 100);
>  
>  	return 0;
>  }

Can you explain why shortening the delay is acceptable here?
										
> @@ -246,7 +246,7 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>  	 * reading duplicate data in the next MDIC transaction.
>  	 */
>  	if (hw->mac.type == e1000_pch2lan)
> -		udelay(100);
> +		usleep_range(90, 110);
>  
>  	return 0;
>  }

And here?
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170904/9f59a019/attachment.asc>
