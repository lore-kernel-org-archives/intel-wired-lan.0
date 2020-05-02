From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 2 May 2020 12:08:21 -0700
Subject: [Intel-wired-lan] i350 not coming out of D3 when link should be
 reestablished
In-Reply-To: <20200502175541.GB7062@faith.camperquake.de>
References: <20200421133745.GA1557688@shell-202.tara.dn.lalufu.net>
 <20200502175541.GB7062@faith.camperquake.de>
Message-ID: <CAKgT0Uf8+sTsc0HCmxvpjYNKpOivV3z0N36zmHJiYzWXtjMTtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, May 2, 2020 at 10:55 AM Ralf Ertzinger <ralf@camperquake.de> wrote:
>
> Hi,
>
> On Tue, Apr 21, 2020 at 01:37:45PM +0000, Ralf Ertzinger wrote:
>
> > I have a Supermicro board (M11SDV-4C-LN4F) which has one (or four? not
> > sure) i350 network cards, breaking out into four 1GB RJ45 ports:
>
> is this the right mailing list for these sort of issues? If not, where
> should I bring this up?

This is the right list

As far as the behavior I am fairly certain it is a bug. I suspect
there are some functions that aren't correctly taking the power saving
features into account and as a result they aren't working correctly.
Unfortunately I don't know how much testing takes place for the igb
parts with run time power management enabled.

- Alex
