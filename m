From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Jun 2016 16:19:59 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 06/17] bnxt: Move GENEVE
 support from hard-coded port to using port notifier
In-Reply-To: <20160615220754.15575.94576.stgit@localhost.localdomain>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
 <20160615220754.15575.94576.stgit@localhost.localdomain>
Message-ID: <CAKgT0UfPFjy7_wuzzfgbPbnyBzZ+grUOnykEbrYSw4=EvhTVFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 15, 2016 at 3:07 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
> The port number for GENEVE is hard coded into the bnxt driver.  This is the
> kind of thing we want to avoid going forward.  For now I will integrate
> this back into the port notifier so that we can change the GENEVE port
> number if we need to in the future.
>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

So it turns out this patch doesn't apply on top of the current tree.
I will submit a v3 of these patches tomorrow after everyone has had a
chance to review.

- Alex
