%                               -*- Mode: Rd -*- 
% insert.Rd --- 
% Author          : Claus Dethlefsen
% Created On      : Sat May 25 23:02:17 2002
% Last Modified By: Claus Dethlefsen
% Last Modified On: Mon Jan 05 14:35:15 2009
% Update Count    : 28
% Status          : Unknown, Use with caution!
% 

\name{insert}
\alias{insert}
\alias{remover}
\encoding{latin1}
%- Also NEED an `\alias' for EACH other topic documented here.

\title{Insert/remove an arrow in network}

\description{Inserts/removes one arrow in a network (if legal)
}

\usage{
insert (nw,j,i,df,prior,nocalc=FALSE,trylist=vector("list",size(nw))) 
remover(nw,j,i,df,prior,nocalc=FALSE,trylist=vector("list",size(nw))) 
}

%- maybe also `usage' for other objects documented here.
\arguments{
  \item{nw}{an object of class \code{\link{network}}.}
  \item{j}{integer, giving the index of the 'from' node.}
  \item{i}{integer, giving the index of the 'to' node.}
  \item{df}{a data frame used for learning the network, see
    \code{\link{network}}.} 
  \item{prior}{a list describing parameter priors, generated by
    \code{\link{jointprior}}.} 
  \item{nocalc}{a logical. If \code{TRUE}, learning is not called.}
  \item{trylist}{a list, used internally for reusing learning of nodes,
    see \code{\link{maketrylist}}.} }

\details{
  Examines if the arrow from \code{j} to \code{i} is legal according to
  the following criteria

  Arrows from/to the same node are not legal.

  Arrows from continous nodes to discrete nodes are not legal.
  
  Arrows banned in ban list are not legal, see \code{\link{drawnetwork}}.
  
  Arrows already existing in the network are not legal.

  If the arrow is not legal, a \code{NULL} network is returned. Otherwise, the
  arrow is inserted/removed, the network is re-learned (if
  \code{nocalc} is \code{FALSE}). The trylist is updated.
}

\value{A list with two elements
  \item{nw}{an object of class \code{\link{network}} with the arrow
    added/removed if this is possible. If not, \code{NULL} is returned.}
  \item{trylist}{an updated list, used internally for reusing learning
    of nodes, see \code{\link{maketrylist}}.}
}

% \references{
%   Further information about \bold{deal} can be found at:\cr
%   \url{http://www.math.aau.dk/~dethlef/novo/deal}.
% }

\author{
  Susanne Gammelgaard Bottcher, \cr
  Claus Dethlefsen \email{rpackage.deal@gmail.com}.
}

%\note{ ~~further notes~~ }

% ~Make other sections like WARNING with \section{WARNING }{....} ~

\examples{
data(rats)
rats.nw    <- network(rats)
rats.nw    <- getnetwork(insert(rats.nw,2,1,nocalc=TRUE))
rats.prior <- jointprior(rats.nw,12)

rats.nw2   <- network(rats)
rats.nw2   <- getnetwork(learn(rats.nw2,rats,rats.prior))
rats.nw2   <- getnetwork(insert(rats.nw2,1,2,rats,rats.prior))

rats.nw3   <- getnetwork(remover(rats.nw2,1,2,rats,rats.prior))
}

\keyword{iplot}
