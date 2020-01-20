From: Ryan Goodfellow <rgoodfel@isi.edu>
Date: Mon, 20 Jan 2020 13:33:09 -0500
Subject: [Intel-wired-lan] zero-copy between interfaces
In-Reply-To: <CAJ8uoz0i2NVxBty18Cq=kK5_Ysue=pt1psBBahLFiZqN168OiQ@mail.gmail.com>
References: <14f9e1bf5c3a41dbaec53f83cb5f0564@isi.edu>
 <CAJ+HfNhdPEe34DVUAj4eHxLkBUSTo2CXbLHoWu+dwFCp753oMg@mail.gmail.com>
 <20200117171637.GB69024@smtp.ads.isi.edu>
 <CAJ8uoz0i2NVxBty18Cq=kK5_Ysue=pt1psBBahLFiZqN168OiQ@mail.gmail.com>
Message-ID: <20200120183309.GA10990@smtp.ads.isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 20, 2020 at 09:24:05AM +0100, Magnus Karlsson wrote:
> 
> I was wondering if you could run two small experiments since I cannot
> reproduce this?
> 
> 1: Run your program using the two ports on your X710 card. Does it
> work? This is my setup and works for me.

The X710 card works without issue.

> 2: On your Mellanox setup, insert a kick_tx() call for each of your
> two sockets before the poll() call in your forward() function. Just to
> see if it works when we explicitly wake up the driver.

This did not have an effect on the observed behavior. Exactly N packets go
through the interface where N is equal to the size of the FQ/CQ rings and then
forwarding halts.

--
~ ry
