From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 11 May 2022 11:52:04 +0200
Subject: [Intel-wired-lan] [PATCH] igb_ethtool: fix efficiency issues in
 igb_set_eeprom
In-Reply-To: <B0201E3D-98F5-490E-81CF-45B16A06760D@gmail.com>
References: <20220510012159.8924-1-lianglixue@greatwall.com.cn>
 <8d7e86ad-932c-d08c-3131-762edd553b22@molgen.mpg.de>
 <B0201E3D-98F5-490E-81CF-45B16A06760D@gmail.com>
Message-ID: <7ee58bc9-bacf-9d16-8f96-5c9beacb5e8a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Lixue,


Am 11.05.22 um 09:59 schrieb lixue liang:

> Thank you very much for your reply and suggestions.I have made the
> corresponding changes according to your suggestion.

Thank you.

> In addition, for the problem that the invalid mac address cannot load
> the igb driver, I personally think there is a better way to modify
> it, and I will resubmit the patch about igb_main.c.

Awesome.

> It's the same question, but I may not know how to continue submitting
> new patches on this email, sorry about that.

As you use `git send-email`, what does `git log` show as the patch 
author? It might be as easy as to do

     git config --global user.name "Lixue Liang"
     git config --global user.email lianglixue at greatwall.com.cn
     git commit --amend --author "Lixue Liang <lianglixue@greatwall.com.cn>"


Kind regards,

Paul


PS: When replying, it?d be great if you used interleaved style [1].


[1]: https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
