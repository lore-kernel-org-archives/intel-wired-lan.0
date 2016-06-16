From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 16 Jun 2016 16:12:02 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 06/17] bnxt: Move GENEVE
 support from hard-coded port to using port notifier
In-Reply-To: <20160616192136.20872.49824.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160616192136.20872.49824.stgit@localhost.localdomain>
Message-ID: <CACKFLinup=5BsJrSiePpVGFdsRDq6wSxt_XnkiDG4LmujXZ0Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 16, 2016 at 12:21 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
> The port number for GENEVE is hard coded into the bnxt driver.  This is the
> kind of thing we want to avoid going forward.  For now I will integrate
> this back into the port notifier so that we can change the GENEVE port
> number if we need to in the future.
>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Acked-by: Michael Chan <michael.chan@broadcom.com>
